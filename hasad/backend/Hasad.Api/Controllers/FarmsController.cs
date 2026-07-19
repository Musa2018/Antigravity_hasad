using Asp.Versioning;
using Hasad.Application.Features.Farms.Commands.CreateFarm;
using Hasad.Application.Features.Farms.Commands.DeleteFarm;
using Hasad.Application.Features.Farms.Commands.UpdateFarm;
using Hasad.Application.Features.Farms.Queries.GetFarmById;
using Hasad.Application.Features.Farms.Queries.GetFarmsByFarmer;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize]
public class FarmsController : ControllerBase
{
    private readonly IMediator _mediator;

    public FarmsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetFarm(Guid id)
    {
        var result = await _mediator.Send(new GetFarmByIdQuery(id));
        return result.Succeeded ? Ok(result) : NotFound(result);
    }

    [HttpGet("farmer/{farmerId}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor,ReadOnly")]
    public async Task<IActionResult> GetFarmsByFarmer(Guid farmerId)
    {
        var result = await _mediator.Send(new GetFarmsByFarmerQuery(farmerId));
        return Ok(result);
    }

    [HttpPost]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> CreateFarm([FromBody] CreateFarmCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPut("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer,FieldSurveyor")]
    public async Task<IActionResult> UpdateFarm(Guid id, [FromBody] UpdateFarmCommand command)
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
    public async Task<IActionResult> DeleteFarm(Guid id)
    {
        var result = await _mediator.Send(new DeleteFarmCommand(id));
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }
}
