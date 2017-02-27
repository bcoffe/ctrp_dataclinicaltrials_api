class DataClinicalTrial

  include Aws::Record
  include Aws::Record::RecordClassMethods
  include Aws::Record::ItemOperations::ItemOperationsClassMethods
  include ActiveModel::Serializers::JSON
  #include ModelSerializer

  set_table_name "#{self.name.underscore}"

  #boolean_attr :active, database_attribute_name: 'is_active_flag'

  string_attr :nci_id, hash_key: true
  string_attr :exported_from_us
  string_attr :gender_description
  string_attr :sequential_assignment
  string_attr :fda_regulated_drug
  string_attr :post_prior_to_approval
  string_attr :ped_postmarket_surv
  string_attr :masking_description
  string_attr :fda_regulated_device
  string_attr :model_description
  string_attr :gender_based

  def self.find_by(nci_id = nil,to_hash = true)
    query = {}
    query.merge!(build_scan_filter(nci_id))
    query[:conditional_operator] = 'AND' if query[:scan_filter].length >= 4
    puts "I am in find by"
    puts scan(query)
    if to_hash
      puts "into hash"
      scan(query).collect(&:to_h)
    else
      puts "into else block "
      scan(query).entries
    end
  end

  def self.find_by_nci_id(nci_id)
    dynamodb = Aws::DynamoDB::Client.new
    response = dynamodb.get_item({
                                     table_name: 'data_clinical_trial',
                                     key: {
                                         'nci_id' => nci_id,
                                     }
                                 })
      item = response.item
  end

  def self.build_scan_filter(nci_id)
    puts "Inside build"
    query = { scan_filter: {} }
    unless nci_id.nil?
      query[:scan_filter]['nci_id'] = { comparison_operator: 'EQ', attribute_value_list: [nci_id] }
    end
    query
  end

    # def self.from_json(string)
    #   data = JSON.load string
    #   created = self.new
    #
    #   created.id = data['id']
    #   created.patient_id = data['patient_id']
    #   created.molecular_id = data['molecular_id']
    #   created.analysis_id = data['analysis_id']
    #   created.type = data['type']
    #   created.status = data['status']
    #   created.comment = data['comment']
    #   created.comment_user = data['comment_user']
    #
    #   return created
    # end

  # def attributes_data
  #   attributes.as_json['data']['data']
  # end
  #
  # def self.serialized_hash(data_clinical_trials, projection = [])
  #   return [] unless data_clinical_trials.present?
  #   if data_clinical_trials.is_a?(Array)
  #     attributes = data_clinical_trials.first.attributes_data.keys
  #     unwanted_attributes = projection.blank? ? [] : attributes - projection
  #     data_clinical_trials.collect { |t| t.attributes_data.delete_keys!(unwanted_attributes) }
  #   elsif data_clinical_trials.is_a?(DataClinicalTrial)
  #     attributes = data_clinical_trials.attributes_data.keys
  #     unwanted_attributes = attributes - projection
  #     data_clinical_trials.attributes_data.delete_keys!(unwanted_attributes)
  #   end
  # end

end