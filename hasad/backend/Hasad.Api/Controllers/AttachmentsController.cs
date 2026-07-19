using Asp.Versioning;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hasad.Api.Controllers;

[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[Authorize]
public class AttachmentsController : ControllerBase
{
    private readonly IMediator _mediator;

    public AttachmentsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    // DELETE: api/attachments/{id}
    [HttpDelete("{id}")]
    [Authorize(Roles = "SuperAdmin,Administrator,AgriculturalEngineer")]
    public IActionResult DeleteAttachment(Guid id)
    {
        // Placeholder for DeleteAttachmentCommand
        return Ok();
    }
}
