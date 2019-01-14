class ActivityWithCountPresenter < BasePresenter
  def initialize(activity_with_count, view)
    @view = view
    @id = activity_with_count.first.first
    @name = activity_with_count.first.second
    @count = activity_with_count.second
  end

  def id
	  @id
  end

  def name
	  @name
  end

  def count
	  @count
  end

  def title
    "#{name} - #{count}"
  end
end
