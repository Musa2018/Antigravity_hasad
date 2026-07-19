using Asp.Versioning;
using Hasad.Application.Features.Users.Commands.CreateUser;
using Hasad.Application.Features.Users.Commands.UpdateUser;
using Hasad.Application.Features.Users.Commands.ResetPassword;
using Hasad.Application.Features.Users.Commands.ChangeUserStatus;
using Hasad.Application.Features.Users.Queries.GetDirectorates;
using Hasad.Application.Features.Users.Queries.GetGovernorates;
using Hasad.Application.Features.Users.Queries.GetRoles;
using Hasad.Application.Features.Users.Queries.GetUsers;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize(Roles = "SuperAdmin")]
public class UsersController : ControllerBase
{
    private readonly IMediator _mediator;

    public UsersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<IActionResult> GetUsers([FromQuery] GetUsersQuery query)
    {
        var result = await _mediator.Send(query);
        return Ok(result);
    }

    [HttpGet("roles")]
    public async Task<IActionResult> GetRoles()
    {
        var result = await _mediator.Send(new GetRolesQuery());
        return Ok(result);
    }

    [HttpGet("governorates")]
    public async Task<IActionResult> GetGovernorates()
    {
        var result = await _mediator.Send(new GetGovernoratesQuery());
        return Ok(result);
    }

    [HttpGet("directorates")]
    public async Task<IActionResult> GetDirectorates([FromQuery] Guid? governorateId)
    {
        var result = await _mediator.Send(new GetDirectoratesQuery(governorateId));
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateUserCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, [FromBody] UpdateUserCommand command)
    {
        if (id != command.Id) return BadRequest("ID mismatch");
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPost("{id}/reset-password")]
    public async Task<IActionResult> ResetPassword(string id, [FromBody] ResetPasswordCommand command)
    {
        if (id != command.UserId) return BadRequest("ID mismatch");
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }

    [HttpPatch("{id}/status")]
    public async Task<IActionResult> ChangeStatus(string id, [FromBody] ChangeUserStatusCommand command)
    {
        if (id != command.UserId) return BadRequest("ID mismatch");
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }
}
