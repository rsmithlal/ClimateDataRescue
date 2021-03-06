field = field || nil
if field_option

    json.id field_option.id
    json.text field_option.name
    json.name field_option.name
    json.name_en field_option.name_en
    json.help field_option.help
    json.value field_option.value
    json.image (field_option.image.present? ? field_option.image : nil)
    json.text_symbol field_option.text_symbol
    json.display_attribute field_option.display_attribute
    json.icon_url (field_option.image.present? ? field_option.image.url(:icon) : nil)
    json.assigned (field && field.field_options.include?(field_option) ? true : false)
    json.is_field_option true
    json.is_default field_option.is_default

    if @fof
        json.position @fof.sort_order
    end

end
