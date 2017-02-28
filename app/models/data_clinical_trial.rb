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

  def self.find_all(nci_id = nil,to_hash = true)
    query = {}
    query.merge!(build_scan_filter(nci_id))
    query[:conditional_operator] = 'AND' if query[:scan_filter].length >= 4
    if to_hash
      scan(query).collect(&:to_h)
    else
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

  def self.format_data(hash, sample)
    hash.nci_id = sample[:nci_id]
    hash.exported_from_us = sample[:exported_from_us]
    hash.gender_description = sample[:model_description]
    hash.sequential_assignment = sample[:sequential_assignment]
    hash.fda_regulated_drug = sample[:fda_regulated_drug]
    hash.post_prior_to_approval = sample[:post_prior_to_approval]
    hash.ped_postmarket_surv = sample[:ped_postmarket_surv]
    hash.masking_description = sample[:masking_description]
    hash.fda_regulated_device = sample[:fda_regulated_device]
    hash.model_description = sample[:model_description]
    hash.gender_based = sample[:model_description]
    hash
  end


  def self.build_scan_filter(nci_id)
    puts "Inside build"
    query = { scan_filter: {} }
    unless nci_id.nil?
      query[:scan_filter]['nci_id'] = { comparison_operator: 'EQ', attribute_value_list: [nci_id] }
    end
    query
  end

end