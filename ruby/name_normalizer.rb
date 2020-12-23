class NameNormalizer
  def normalize(name)
    return name if name == ""
    parse(name)
    return name if is_mononym?
    return "#{last}, #{first}" if is_duonym?
    return "#{last}, #{first} #{middle_initials}#{suffix}"
  end

  private
  def throw_on_excess_commas(name)
    raise ArgumentError.new if name.count(",") > 1
  end

  def parse(name)
    throw_on_excess_commas name
    @base_name, @suffix = name.split(",")
    @parts = @base_name.split(" ")
  end

  def is_mononym?
    @parts.size == 1
  end

  def is_duonym?
    @parts.size == 2
  end

  def initial(name_part)
    name_part.size == 1 ? name_part : "#{name_part[0]}."
  end

  def middle_initials
    @parts
      .slice(1..-2)
      .map {| part | initial(part)}
      .join(" ")
  end

  def suffix
    if @suffix then ",#{@suffix}" else "" end
  end

  def first
    @parts[0]
  end

  def last
    @parts[-1]
  end
end