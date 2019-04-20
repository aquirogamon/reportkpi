module ApplicationHelper

	def page_entries_info(collection, options = {})
	  entry_name = options[:entry_name] || (collection.empty?? 'item' :
	      collection.first.class.name.split('::').last.titleize)
	  if collection.total_pages < 2
	    case collection.size
	    when 0; "No #{entry_name.pluralize} found"
	    else; "Mostrando todo #{entry_name.pluralize}"
	    end
	  else
	    %{%d - %d de %d } % [
	      collection.offset + 1,
	      collection.offset + collection.length,
	      collection.total_entries
	    ]
	  end
	end

	def link_to_add_fields(name, f, type)
		new_object = f.object.send "build_#{type}"
		id = "new_#{type}"
		fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
			render(type.to_s + "_fields", f: builder)
		end
		link_to(name, '#', class: "add_fields btn btn-sm btn-info form-row", data: {id: id, fields: fields.gsub("\n", "")})
	end



end