def normalize(name: str) -> str:
    trimmed = name.strip()

    (names, suffix) = trimmed.split(",") if "," in trimmed else (trimmed, None)
    result = build_name(names.split(" "))

    if suffix:
        return f"{result}, {suffix.strip()}"

    return result


def build_name(names) -> str:
    if len(names) == 0:
        return ""
    if len(names) == 1:
        return names[0]
    if len(names) == 2:
        return names[1] + ", " + names[0]
    if len(names) > 2:
        return f"{names[-1]}, {names[0]} {handle_middle_names(names[1:-1])}"


def handle_middle_names(middle_names) -> str:
    if len(middle_names) == 1 and len(middle_names[0]) == 1:
        return middle_names[0]

    return " ".join([name[0] + "." for name in middle_names if len(name) > 0])

