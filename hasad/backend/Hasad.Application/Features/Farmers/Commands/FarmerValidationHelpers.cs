using System;

namespace Hasad.Application.Features.Farmers.Commands;

public static class FarmerValidationHelpers
{
    public static string FormatIdNumber(int idTypeId, string idNumber)
    {
        if (string.IsNullOrWhiteSpace(idNumber)) return string.Empty;
        idNumber = idNumber.Trim();
        if ((idTypeId == 1 || idTypeId == 2) && idNumber.Length < 9 && idNumber.All(char.IsDigit))
        {
            return idNumber.PadLeft(9, '0');
        }
        return idNumber;
    }

    public static bool ValidatePalestinianId(string idNumber)
    {
        if (string.IsNullOrWhiteSpace(idNumber))
            return false;

        idNumber = FormatIdNumber(1, idNumber);
        if (idNumber.Length != 9)
            return false;

        if (!idNumber.All(char.IsDigit))
            return false;

        var digits = idNumber.ToCharArray();
        int formula = 0;

        for (int i = 0; i <= digits.Length - 2; i++)
        {
            int digit = int.Parse(digits[i].ToString());

            if (i % 2 == 0)
            {
                formula += digit * 1;
            }
            else
            {
                int temp = digit * 2;

                if (temp >= 10)
                    temp -= 9;

                formula += temp;
            }
        }

        formula += int.Parse(digits[8].ToString());

        return formula % 10 == 0;
    }

    public static bool IsNumeric(string value)
    {
        if (string.IsNullOrWhiteSpace(value)) return false;
        value = value.Trim();
        return value.All(char.IsDigit);
    }

    public static bool IsAlphanumeric(string value)
    {
        if (string.IsNullOrWhiteSpace(value)) return false;
        foreach (char c in value)
        {
            if (!char.IsLetterOrDigit(c))
                return false;
        }
        return true;
    }

    public static bool IsAtLeast18(DateOnly birthDate)
    {
        var today = DateOnly.FromDateTime(DateTime.UtcNow);
        int age = today.Year - birthDate.Year;

        if (birthDate > today.AddYears(-age)) age--;

        return age >= 18;
    }
}
