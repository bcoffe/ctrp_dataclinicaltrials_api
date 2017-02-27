
module Api::V1
  class DataClinicalTrialsController < ApplicationController

    #before_action :set_data_clinical_trail, only: [:show]

    before_action :set_data_clinical_trails, only: ['index']

    # GET /data_clinical_trails
    # GET /data_clinical_trails.json
    def index
      begin
         @data_clinical_trials = DataClinicalTrial.find_by()
         render json: @data_clinical_trials
      rescue => error
        standard_error_message(error)
      end
    end

    def show
      begin
        puts " **** this is passing  ***"
        @data_clinical_trial = DataClinicalTrial.find_by_nci_id(params[:id])
        render json: @data_clinical_trial
      rescue => error
        standard_error_message(error)
      end
    end

    # def create
    #     begin
    #
    #     end
    # end




    # def save
    #   puts " **** inside save   ***"
    #   exported_from_us  = params['exported_from_us']
    #   gender_description   = params['gender_description']
    #   sequential_assignment = params['sequential_assignment']
    #   fda_regulated_drug  = params['fda_regulated_drug']
    #   post_prior_to_approval  = params['post_prior_to_approval']
    #   ped_postmarket_surv   = params['ped_postmarket_surv']
    #   masking_description = params['masking_description']
    #   fda_regulated_device  = params['fda_regulated_device']
    #   model_description  = params['model_description']
    #   gender_based   = params['gender_based']
    #   nci_id = params['nci_id']
    #
    #   aws_params = Hash.new
    #   aws_params[:nci_id] = nci_id
    #   aws_params[:custom_fields]    = {
    #       'exported_from_us'  => exported_from_us,
    #       'gender_description'   => gender_description,
    #       'sequential_assignment' => sequential_assignment,
    #       'fda_regulated_drug'  => fda_regulated_drug,
    #       'post_prior_to_approval'  => post_prior_to_approval,
    #       'ped_postmarket_surv'   => ped_postmarket_surv,
    #       'masking_description' => masking_description,
    #       'fda_regulated_device'  => fda_regulated_device,
    #       'model_description'  => model_description,
    #       'gender_based'   => gender_based,
    #   }
    #   if Aws.save_records_to_db(aws_params)
    #     flash[:notice] = "Message Sent!"
    #   else
    #     flash[:error] = "Error While Save to DynamoDB!"
    #   end
    #   redirect_to root_path
    # end
    #
    # # GET /data_clinical_trails/1
    # # GET /data_clinical_trails/1.json
    # def show
    #   #render json: DataClinicalTrial.serialized_hash(@data_clinical_trail)
    # end
    #
    # # POST /data_clinical_trails
    # # POST /data_clinical_trails.json
    # def create
    #   @data_clinical_trail = DataClinicalTrail.new(data_clinical_trail_params)
    #
    #   if @data_clinical_trail.save
    #     render :show, status: :created, location: @data_clinical_trail
    #   else
    #     render json: @data_clinical_trail.errors, status: :unprocessable_entity
    #   end
    # end
    #
    # # PATCH/PUT /data_clinical_trails/1
    # # PATCH/PUT /data_clinical_trails/1.json
    # def update
    #   if @data_clinical_trail.update(data_clinical_trail_params)
    #     render :show, status: :ok, location: @data_clinical_trail
    #   else
    #     render json: @data_clinical_trail.errors, status: :unprocessable_entity
    #   end
    # end
    #
    # # DELETE /data_clinical_trails/1
    # # DELETE /data_clinical_trails/1.json
    # def destroy
    #   @data_clinical_trail.destroy
    # end
    #
    private

    #Use callbacks to share common setup or constraints between actions.
    def set_data_clinical_trail
      @data_clinical_trail = DataClinicalTrail.find_by_nci_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_clinical_trail_params
      params.fetch(:data_clinical_trail, {})
    end

    private

    def set_data_clinical_trails
      params[:active] == 'true' ? true : false if params[:active].present?
      if attribute_params.present? || projection_params.present?
        ta_json = filter_query_by_attributes(DataClinicalTrial.scan({}))
      else
        ta_json = filter_query(DataClinicalTrial.scan({}))
      end
      @data_clinical_trials = ta_json #.sort { |x, y| y.date_created <=> x.date_created }
    end

    def projection_params
      params[:projection] || [] if params[:projection].is_a?(Array)
    end

    def attribute_params
      params[:attribute] || [] if params[:attribute].is_a?(Array)
    end

    def filter_query(query_result)
      return [] if query_result.nil?
      [:nci_id].each do |key|
        unless params[key].nil?
          new_query_result = query_result.select { |t| t.send(key) == params[key] }
          query_result = new_query_result
        end
      end
      query_result
    end

  end

end


