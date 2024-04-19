export function normalize(input: string): string {
  throwWhenExcessCommas(input);
  const trimmed = input.trim();
  if (isMononym(trimmed)) {
    return trimmed;
  }

  const nameParts = splitToNameParts(trimmed);
  if (isDuonym(nameParts)) {
    const { first, last } = nameParts;
    return `${last}, ${first}`;
  }
  return `${nameParts.last}, ${nameParts.first} ${formatMiddleInitials(
    nameParts.middles
  )}${formatSuffix(nameParts.suffix)}`;
}

const throwWhenExcessCommas = (input: string) => {
  const commaCount = [...input].filter((c) => c === ",").length;
  if (commaCount > 1) throw new Error();
};

const isMononym = (trimmed: string) => !trimmed.trim().includes(" ");

const isDuonym = (parts: NameParts) =>
  parts.middles.length === 0 && !parts.suffix;

const formatMiddleInitial = (middleName: string) =>
  middleName.length === 1 ? middleName : middleName[0] + ".";

const formatMiddleInitials = (parts: string[]) =>
  parts.map(formatMiddleInitial).join(" ");

const formatSuffix = (suffix?: string) => (suffix ? `, ${suffix}` : "");

type NameParts = {
  first: string;
  last: string;
  middles: string[];
  suffix?: string;
};

const splitToNameParts = (input: string): NameParts => {
  const [fullName, suffix] = input.split(", ");
  const nameParts = fullName.split(" ");
  return {
    first: nameParts[0],
    last: nameParts[nameParts.length - 1],
    middles: nameParts.slice(1, -1),
    suffix: suffix,
  };
};
