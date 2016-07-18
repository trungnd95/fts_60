module ApplicationHelper
  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add_fields btn-floating btn-large
      waves-effect waves-light red", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def spend_time exam
    time = exam.subject.duration * Settings.MINUTE
    if exam.end_time - exam.start_time <= exam.subject.duration * Settings.MINUTE
      time = exam.end_time - exam.start_time
    end
    Time.at(time).utc.strftime Settings.TIME_FORMAT
  end
end
