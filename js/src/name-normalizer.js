export const normalize = name => {
  throwWhenNameContainsTooManyCommas(name);
  const parts = suffixless(name).trim().split(' ');
  if (parts.length === 1) return name;
  return `${lastName(parts)}, ${firstName(parts)}${middleInitials(parts)}${suffix(name)}`;
}

const throwWhenNameContainsTooManyCommas = name => {
  if (commaCount(name) > 1)
    throw new TypeError();
}

const middleInitials = parts => {
  if (parts.length <= 2) return "";
  return parts.slice(1, -1).map(initial).join('');
}

const suffixless = name => name.split(',')[0];

const suffix = name => {
  var suffix = name.split(',')[1];
  return suffix ? `,${suffix}` : '';
}

const initial = name => ` ${name[0]}${name.length === 1 ? '': '.'}`;

const lastName = parts => parts[parts.length - 1];

const firstName = parts => parts[0];

const commaCount = name => (name.match(/,/g) || []).length;
