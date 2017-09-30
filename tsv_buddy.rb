# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format

  def structure_data(line,titles)
    row = Hash.new
    line_splitted = line.split("\t")
    line_splitted.each_with_index do |col, i|
      row[titles[i]] = col
    end
    return row
  end

  def get_headers_string(data)
    data.first.split("\t")
  end

  def structure_string(split_info,header)
    split_info.each_with_index  do |line, index|
      next if index.zero?
      @data << structure_data(line,header)
    end
  end

  def take_tsv(tsv)
    rows = tsv.split("\n")
    header = get_headers_string(rows)
    @data = []
    structure_string(rows,header)
    @data
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format

  def get_headers_data_structured(data)
    heads = data.first.keys.join("\t") << "\n"
    heads
  end

  def string_the_data(data)
    data_string =""
    data.each { |line| data_string << line.values.join("\t") << "\n" }
    data_string
  end

  def to_tsv
    output_string = get_headers_data_structured(@data)
    output_string << string_the_data(data)
    output_string
  end
end
