module TodosHelper
  def tasks_with_tag_path tag
    tags = tag

    if params[:tags]
      tags = params[:tags].split(',')

      if tags.include?(tag)
        tags.delete(tag)
      else 
        tags.push(tag)
      end

      tags = tags.join(',')
    end

    tags.blank? ? url_for(params.except(:tags)) : url_for(params.merge({ :tags => tags }))
  end

  def tag_in_params tag
    if params[:tags]
      params[:tags].split(',').include?(tag)
    end
  end
end
