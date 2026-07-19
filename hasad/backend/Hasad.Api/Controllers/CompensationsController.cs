using Asp.Versioning;
using Hasad.Application.Features.Compensations.Commands.CreateCompensation;
using Hasad.Application.Features.Compensations.Commands.UpdateCompensation;
using Hasad.Application.Features.Compensations.Commands.ApproveCompensation;
using Hasad.Application.Features.Compensations.Commands.RejectCompensation;
using Hasad.Application.Features.Compensations.Commands.MarkAsPaidCompensation;
using Hasad.Application.Features.Compensations.Commands.RecalculateCompensation;
using Hasad.Application.Features.Compensations.Commands.SubmitCompensation;
using Hasad.Application.Features.Compensations.Queries.GetCompensationByReportId;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize]
public class CompensationsController : ControllerBase
{
    private readonly IMediator _mediator;

    public CompensationsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("report/{reportId}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetByReportId(Guid reportId)
    {
        var result = await _mediator.Send(new GetCompensationByReportIdQuery(reportId));
        return Ok(result);
    }

    [HttpPost]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer")]
    public async Task<IActionResult> Create([FromBody] CreateCompensationCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/recalculate")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer")]
    public async Task<IActionResult> Recalculate(Guid id, [FromBody] RecalculateCompensationCommand command)
    {
        if (id != command.Id) return BadRequest(new { Errors = new[] { "ID mismatch." } });
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/submit")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer")]
    public async Task<IActionResult> Submit(Guid id, [FromBody] SubmitCompensationCommand command)
    {
        if (id != command.Id) return BadRequest(new { Errors = new[] { "ID mismatch." } });
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/approve")]
    [Authorize(Roles = "SuperAdmin,Administrator")]
    public async Task<IActionResult> Approve(Guid id, [FromBody] ApproveCompensationCommand command)
    {
        if (id != command.Id) return BadRequest(new { Errors = new[] { "ID mismatch." } });
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/reject")]
    [Authorize(Roles = "SuperAdmin,Administrator")]
    public async Task<IActionResult> Reject(Guid id, [FromBody] RejectCompensationCommand command)
    {
        if (id != command.Id) return BadRequest(new { Errors = new[] { "ID mismatch." } });
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/pay")]
    [Authorize(Roles = "SuperAdmin,Administrator")]
    public async Task<IActionResult> MarkAsPaid(Guid id, [FromBody] MarkAsPaidCompensationCommand command)
    {
        if (id != command.Id) return BadRequest(new { Errors = new[] { "ID mismatch." } });
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }
}
