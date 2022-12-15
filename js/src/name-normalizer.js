const lastName = parts => parts[1]

const firstName = parts => parts[0]

const isMononym = parts => parts.length === 1

export const normalize = name => {
  const parts = name.trim().split(' ')
  if (isMononym(parts)) return name
  return `${(lastName(parts))}, ${(firstName(parts))}`
}
