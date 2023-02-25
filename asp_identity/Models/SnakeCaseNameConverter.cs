using System.Globalization;
using System.Text;

namespace asp_identity.Models;

public sealed class SnakeCaseNameConverter
{
    public static char Separator { get; set; } = '_';

    public static string Convert(string value)
    {
        if (string.IsNullOrEmpty(value))
            return value;

        var builder = new StringBuilder(value.Length + Math.Min(2, value.Length / 5));
        var previousCategory = default(UnicodeCategory?);

        for (var currentIndex = 0; currentIndex < value.Length; currentIndex++)
        {
            var currentChar = value[currentIndex];
            if (currentChar == Separator)
            {
                builder.Append(Separator);
                previousCategory = null;
                continue;
            }

            var currentCategory = char.GetUnicodeCategory(currentChar);
            switch (currentCategory)
            {
                case UnicodeCategory.UppercaseLetter:
                case UnicodeCategory.TitlecaseLetter:
                    if (previousCategory == UnicodeCategory.SpaceSeparator ||
                        previousCategory == UnicodeCategory.LowercaseLetter ||
                        (previousCategory != UnicodeCategory.DecimalDigitNumber &&
                         previousCategory != null &&
                         currentIndex > 0 &&
                         currentIndex + 1 < value.Length &&
                         char.IsLower(value[currentIndex + 1])))
                        builder.Append(Separator);

                    currentChar = char.ToLower(currentChar);
                    break;

                case UnicodeCategory.LowercaseLetter:
                case UnicodeCategory.DecimalDigitNumber:
                    if (previousCategory == UnicodeCategory.SpaceSeparator)
                        builder.Append(Separator);
                    break;

                default:
                    if (previousCategory != null)
                        previousCategory = UnicodeCategory.SpaceSeparator;
                    continue;
            }

            builder.Append(currentChar);
            previousCategory = currentCategory;
        }

        return builder.ToString();
    }
}