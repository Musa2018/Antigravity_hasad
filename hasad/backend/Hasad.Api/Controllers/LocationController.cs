using Asp.Versioning;
using Hasad.Application.Features.Location.Queries.GetGovernorates;
using Hasad.Application.Features.Location.Queries.GetLocalities;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize]
public class LocationController : ControllerBase
{
    private readonly IMediator _mediator;

    public LocationController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("governorates")]
    public async Task<IActionResult> GetGovernorates()
    {
        var result = await _mediator.Send(new GetGovernoratesQuery());
        return Ok(result);
    }

    [HttpGet("localities")]
    public async Task<IActionResult> GetLocalities([FromQuery] Guid? governorateId)
    {
        var result = await _mediator.Send(new GetLocalitiesQuery(governorateId));
        return Ok(result);
    }
}
