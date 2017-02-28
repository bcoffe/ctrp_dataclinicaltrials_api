module Api::V1
  class DataClinicalTrialsController < ApplicationController

    #include HTTParty
    #before_action :set_data_clinical_trail, only: [:show]

    # skip_before_action :verify_authenticity_token
    # before_action :set_data_clinical_trails, only: ['index']

    # GET /data_clinical_trails
    # GET /data_clinical_trails.json
    def index
      begin
         @data_clinical_trials = DataClinicalTrial.find_all()
         render json: @data_clinical_trials
      rescue => error
        standard_error_message(error)
      end
    end

    # GET /data_clinical_trails/1
    # GET /data_clinical_trails/1.json
    def show
      begin

        @data_clinical_trial = DataClinicalTrial.find_by_nci_id(params[:id])
        render json: @data_clinical_trial
      rescue => error
        standard_error_message(error)
      end
    end

    # POST /data_clinical_trails
    # POST /data_clinical_trails.json
    def create
        begin
           data_clinical_trail = DataClinicalTrial.new
          json = JSON.parse(request.raw_post)
          json.deep_transform_keys!(&:underscore).symbolize_keys!
          DataClinicalTrial.format_data(data_clinical_trail, json)
          data_clinical_trail.save
          render json: { message: 'Message has been processed successfully' }, status: 200
        rescue => error
          standard_error_message(error)
        end
    end

    # # PATCH/PUT /data_clinical_trails/1
    # # PATCH/PUT /data_clinical_trails/1.json
    # def update
    #   if @data_clinical_trail.update(data_clinical_trail_params)
    #     render :show, status: :ok, location: @data_clinical_trail
    #   else
    #     render json: @data_clinical_trail.errors, status: :unprocessable_etity
    #   end
    # end
    #
    # # DELETE /data_clinical_trails/1
    # # DELETE /data_clinical_trails/1.json
    # def destroy
    #   @data_clinical_trail.destroy
    # end

    private

  end

end


