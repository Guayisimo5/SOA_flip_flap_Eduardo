# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format

  def structure_data(line)
    row = Hash.new
    line_splitted = line.split("\t")
    line_splitted.each_with_index do |col, i|
      row[@header[i]] = col
    end
    return row
  end
  def take_tsv(tsv)
    rows = tsv.split("\n")
    @header = rows.first.split("\t")
    @data = []
    rows.each_with_index  do |line, index|
      next if index.zero?
      @data << structure_data(line)
    end
    @data
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    output = @data.first.keys.join("\t") << "\n"
    @data.each { |line| output << line.values.join("\t") << "\n" }
    output
  end
end
