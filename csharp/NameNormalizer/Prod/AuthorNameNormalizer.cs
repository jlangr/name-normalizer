using System;
using System.Collections.Generic;
using System.Linq;

namespace Prod
{
    public class AuthorNameNormalizer
    {
        public string Normalize(string name)
        {
            ThrowWhenContainsTooManyCommas(name);
            var parts = Suffixless(name).Trim().Split(' ');
            if (parts.Length == 1)
                return name;
            return $"{LastName(parts)}, {FirstName(parts)}{MiddleInitials(parts)}{Suffix(name)}";
        }

        private void ThrowWhenContainsTooManyCommas(string name)
        {
            if (name.Count(c => c == ',') > 1)
                throw new ArgumentException();
        }

        private string Suffix(string name)
        {
            var i = name.IndexOf(',');
            if (i == -1) return "";
            return name.Substring(i);
        }

        private string Suffixless(string name)
        {
            var i = name.IndexOf(',');
            if (i == -1) return name;
            return name.Substring(0, i);
        }

        private string MiddleInitials(string[] parts)
        {
            var middleNames = parts.Skip(1).Take(parts.Length - 2);
            return string.Join("", middleNames.Select(Initial));
        }

        private string Initial(string name)
        {
            var period = (name.Length > 1) ? "." : "";
            return $" {name[0]}{period}";
        }

        private string FirstName(string[] parts)
        {
            return parts[0];
        }

        private string LastName(string[] parts)
        {
            return parts[parts.Length - 1];
        }
        
    }
}
