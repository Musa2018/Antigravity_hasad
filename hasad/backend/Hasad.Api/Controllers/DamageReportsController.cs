using Asp.Versioning;
using Hasad.Application.Features.DamageReports.Commands.AddDamageItem;
using Hasad.Application.Features.DamageReports.Commands.CreateDamageReport;
using Hasad.Application.Features.DamageReports.Commands.DeleteDamageItem;
using Hasad.Application.Features.DamageReports.Commands.DeleteDamageReport;
using Hasad.Application.Features.DamageReports.Commands.UpdateDamageItem;
using Hasad.Application.Features.DamageReports.Commands.UpdateDamageReport;
using Hasad.Application.Features.DamageReports.Commands.UploadAttachment;
using Hasad.Application.Features.DamageReports.Queries.GetDamageReportById;
using Hasad.Application.Features.DamageReports.Queries.GetDamageReportsByFarm;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize]
public class DamageReportsController : ControllerBase
{
    private readonly IMediator _mediator;

    public DamageReportsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetDamageReport(Guid id)
    {
        var result = await _mediator.Send(new GetDamageReportByIdQuery(id));
        return result.Succeeded ? Ok(result) : NotFound(result);
    }

    [HttpGet("farm/{farmId}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetDamageReportsByFarm(Guid farmId)
    {
        var result = await _mediator.Send(new GetDamageReportsByFarmQuery(farmId));
        return Ok(result);
    }

    [HttpPost]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> CreateDamageReport([FromBody] CreateDamageReportCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPut("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> UpdateDamageReport(Guid id, [FromBody] UpdateDamageReportCommand command)
    {
        if (id != command.Id)
        {
            return BadRequest(new { Errors = new[] { "ID in route does not match ID in body." } });
        }

        var result = await _mediator.Send(command);
        if (result.Succeeded) return Ok(result);

        if (result.Errors.Any(e => e.Contains("CONFLICT")))
        {
            return Conflict(result);
        }

        return BadRequest(result);
    }

    [HttpDelete("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer")]
    public async Task<IActionResult> DeleteDamageReport(Guid id)
    {
        var result = await _mediator.Send(new DeleteDamageReportCommand(id));
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    // Damage Items endpoints

    [HttpPost("{id}/items")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> AddDamageItem(Guid id, [FromBody] AddDamageItemCommand command)
    {
        if (id != command.DamageReportId)
        {
            return BadRequest(new { Errors = new[] { "Report ID mismatch." } });
        }
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPut("items/{itemId}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> UpdateDamageItem(Guid itemId, [FromBody] UpdateDamageItemCommand command)
    {
        if (itemId != command.Id)
        {
            return BadRequest(new { Errors = new[] { "Item ID mismatch." } });
        }
        var result = await _mediator.Send(command);
        if (result.Succeeded) return Ok(result);
        if (result.Errors.Any(e => e.Contains("CONFLICT"))) return Conflict(result);
        return BadRequest(result);
    }

    [HttpDelete("items/{itemId}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer")]
    public async Task<IActionResult> DeleteDamageItem(Guid itemId)
    {
        var result = await _mediator.Send(new DeleteDamageItemCommand(itemId));
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/attachments")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> UploadAttachment(Guid id, [FromForm] IFormFile file, [FromForm] Guid clientId)
    {
        if (file == null || file.Length == 0) return BadRequest("No file uploaded.");

        using var stream = file.OpenReadStream();
        var command = new UploadAttachmentCommand(
            id,
            clientId,
            stream,
            file.FileName,
            file.ContentType,
            file.Length,
            null, // Could get from form if needed
            null,
            null
        );

        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }
}
