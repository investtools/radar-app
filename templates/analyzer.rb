require 'radar-api'

class ClassName

  def config
    Radar::API::AnalyzerConfig.new(
        result_type: Radar::API::ResultType::TABLE,
        accepted_events: Set.new([Radar::API::Event::EACH_DAY, Radar::API::Event::EACH_MONTH, Radar::API::Event::FINISH])
    )
  end

  def on_each_day(portfolio)
  end

  def on_finish(portfolio)
  end

  def dump()
  end

  def resume(data)
  end

  def result()
  end

end