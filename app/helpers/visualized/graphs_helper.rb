module Visualized::GraphsHelper
  def hour_chart
    library_options = {
      scales: {
        yAxes: [{
          ticks: {
            stepSize: 1
          }
        }]
      }
    }
    line_chart visualized_graphs_chart_data_path(period: 'hour', date: params[:date]),
               xtitle: '時間帯', ytitle: '投稿数',
               curve: false,
               discrete: true,
               library: library_options
  end

  def day_chart
    library_options = {
    }
    line_chart visualized_graphs_chart_data_path(period: 'day', date: params[:date]),
               xtitle: '日付', ytitle: '投稿数',
               curve: false,
               discrete: true,
               library: library_options
  end

  def month_chart
    library_options = {
    }
    line_chart visualized_graphs_chart_data_path(period: 'month', date: params[:date]),
               xtitle: '月', ytitle: '投稿数',
               curve: false,
               discrete: true,
               library: library_options
  end

  def country_chart
    library_options = {
    }
    pie_chart visualized_graphs_countries_data_path,
              height: '300px',
              library: library_options
  end

  def generation_chart
    library_options = {
    }
    pie_chart visualized_graphs_generation_data_path,
              height: '300px',
              library: library_options
  end

  def gender_ratio(gender)
    return 0 if @gender_ratio[gender].nil?
    @gender_ratio[gender]
  end

  def selected_date(date)
    return "本日" if date.nil?
    div = date.split('-')
    "#{div[0]}年#{div[1]}月#{div[2]}日"
  end

  def selected_year(date)
    return "#{Time.zone.now.year}年" if date.nil?
    div = date.split('-')
    "#{div[0]}年"
  end

end
