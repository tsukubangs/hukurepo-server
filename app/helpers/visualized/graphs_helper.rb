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
    line_chart visualized_graphs_chart_data_path(period: 'hour'),
               xtitle: '時間帯', ytitle: '投稿数',
               curve: false,
               discrete: true,
               library: library_options
  end

  def day_chart
    library_options = {
    }
    line_chart visualized_graphs_chart_data_path(period: 'day'),
               xtitle: '日付', ytitle: '投稿数',
               curve: false,
               discrete: true,
               library: library_options
  end

  def month_chart
    library_options = {
    }
    line_chart visualized_graphs_chart_data_path(period: 'month'),
               xtitle: '月', ytitle: '投稿数',
               curve: false,
               discrete: true,
               library: library_options
  end

  def country_chart
    library_options = {
    }
    pie_chart visualized_graphs_countries_data_path,
              library: library_options
  end
end
