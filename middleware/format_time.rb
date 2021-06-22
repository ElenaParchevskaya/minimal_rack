class FormatTime
  FORMAT_TIME = {year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S'}.freeze

  def initialize(format_user)
    @format_user = format_user
    check_format
  end

  def check_format
    format = @format_user.split(',')
    @invalid_format = format.reject{ |format| FORMAT_TIME.key? format.to_sym }
    @valid_format = format - @invalid_format
  end

  def apply?
    @invalid_format.empty?
  end

  def return_date
    if apply?
      format = @valid_format.map { |format| FORMAT_TIME[format.to_sym] }
      Time.now.strftime(format.join('-'))
    else
      "Unknown time format #{@invalid_format}"
    end
  end
end
