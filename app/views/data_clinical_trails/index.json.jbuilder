puts "**************"
puts @data_clinical_trials

json.array! @data_clinical_trails, partial: 'data_clinical_trails/data_clinical_trail', as: :data_clinical_trail
