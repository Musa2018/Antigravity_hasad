namespace Hasad.Domain.Constants;

public static class CompensationStatus
{
    public const string Draft = "Draft";
    public const string Calculated = "Calculated";
    public const string Submitted = "Submitted";
    public const string Approved = "Approved";
    public const string Rejected = "Rejected";
    public const string Paid = "Paid";

    private static readonly Dictionary<string, string[]> ValidTransitions = new()
    {
        { Draft, new[] { Calculated } },
        { Calculated, new[] { Draft, Submitted } },
        { Submitted, new[] { Approved, Rejected } },
        { Approved, new[] { Paid } },
        { Rejected, new[] { Draft } },
        { Paid, Array.Empty<string>() }
    };

    public static bool CanTransition(string currentStatus, string nextStatus)
    {
        return ValidTransitions.TryGetValue(currentStatus, out var nextStatuses) &&
               nextStatuses.Contains(nextStatus);
    }
}
