using Asp.Versioning;
using Hasad.Application.Features.Farmers.Commands.CreateFarmer;
using Hasad.Application.Features.Farmers.Commands.DeleteFarmer;
using Hasad.Application.Features.Farmers.Commands.UpdateFarmer;
using Hasad.Application.Features.Farmers.Queries.GetFarmerById;
using Hasad.Application.Features.Farmers.Queries.GetFarmersList;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize]
public class FarmersController : ControllerBase
{
    private readonly IMediator _mediator;

    public FarmersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetFarmers([FromQuery] GetFarmersListQuery query)
    {
        var result = await _mediator.Send(query);
        return Ok(result);
    }

    [HttpGet("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetFarmer(Guid id)
    {
        var result = await _mediator.Send(new GetFarmerByIdQuery(id));
        return result.Succeeded ? Ok(result) : NotFound(result);
    }

    [HttpPost]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> CreateFarmer([FromBody] CreateFarmerCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPut("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> UpdateFarmer(Guid id, [FromBody] UpdateFarmerCommand command)
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
    public async Task<IActionResult> DeleteFarmer(Guid id)
    {
        var result = await _mediator.Send(new DeleteFarmerCommand(id));

        if (!result.Succeeded)
        {
            // نتحقق إذا كان سبب الفشل هو عدم وجود المزارع لنرجع 404
            if (result.Errors.Any(e => e.Contains("not found")))
            {
                return NotFound(result);
            }

            return BadRequest(result);
        }

        // عند النجاح نرجع 204 No Content
        return NoContent();
    }
}