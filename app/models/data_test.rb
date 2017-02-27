class DataTest
  include Aws::Record

  set_table_name "#{self.name.underscore}"

  #boolean_attr :active, database_attribute_name: 'is_active_flag'
  string_attr :id, hash_key: true
  string_attr :name

  def self.find_by(id = nil,to_hash = true)
    query = {}
   # query.merge!(build_scan_filter(id))
    #query[:conditional_operator] = 'AND'# if query[:scan_filter].length >= 2
    if to_hash
      scan(query).collect(&:to_h)
    else
      scan(query).entries
    end
  end
end
