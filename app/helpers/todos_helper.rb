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

    tags.blank? ? root_path : root_path(params.merge({ :tags => tags }))
  end
end
