if @annotation
    json.id @annotation.id
    json.date @annotation.date_time_id.split("_")[0]
    json.time @annotation.date_time_id.split("_")[1]
    json.width @annotation.width
    json.height @annotation.height
    json.x_tl @annotation.x_tl
    json.y_tl @annotation.y_tl
    
    json.field_group do
        json.id @annotation.field_group_id
        json.name @annotation.field_group.presentation_name
        json.fields do
            json.array! @annotation.field_group.fields do |field|
                json.id field.id
                json.name field.name
                json.value (@annotation.data_entries.find_by(field_id: field.id) ? @annotation.data_entries.find_by(field_id: field.id).value : nil )
            end
        end
    end
end