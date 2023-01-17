require_relative '../../search_test'
require_relative '../../generator/group_metadata'

module USCoreTestKit
  module USCoreV400
    def patient_id_list
      return [nil] unless respond_to? :patient_ids

      patient_ids.split(',').map(&:strip)
    end

    class PatientNameValidateTest < Inferno::Test
      include USCoreTestKit::SearchTest

      title 'Validate the name of the patient returned'
      id :hls_patient_name_validate_test

      input :patient_ids,
        title: 'List of patient Ids (only first will be used)'

      input :last_name,
        title: 'Expected patient name'

      makes_request :patient

      run do
        puts "***Log: Parameters Url: '#{url}' PatientIds: '#{patient_ids}', First Id: '#{patient_id_list[0]}' Expected name: '#{last_name}' Creds: #{smart_credentials}}"   

        fhir_read(:patient, patient_id_list[0])

        assert_response_status(200)

        assert_resource_type(:patient)
        puts "***Log: last_name '#{last_name}' is of type #{:last_name.class}, family '#{resource.name[0].family}' is of type #{resource.name[0].family.class}. They are equal? #{last_name.to_s == resource.name[0].family}"

        # Note: :last_name is a symbol - not a string, you must not use the colon and convert it via to_s if not using interprolation (which does an implicit to_s)
        assert last_name.to_s == resource.name[0].family, "'#{last_name}' does not equal '#{resource.name[0].family}'"

        #search: try 'HumanName'

      end

      class PatientNameSearchTest < Inferno::Test
        include USCoreTestKit::SearchTest
  
        title 'Search for a given patient by family (last) name'
        id :hls_patient_name_search_test
  
        input :last_name,
          title: 'Expected patient name'
          
          run do


            params = { family: last_name.to_s }
            puts "***Log: PatientNameSearchTest: '#{params}'"

            fhir_search resource_type: 'Patient', params: params

            # Example code...
#            search_and_check_response
#            perform_search_with_status
#            def document_reference_types_found(patient_id)
#              search_params = { patient: patient_id }
#              status_values = ['current,superseded,entered-in-error']
#        
# Handling responses...
#              if response[:status] == 400
#                perform_search_with_status(
#                  params,
#                  patient_id,
#                  status_search_values: status_values,
#                  resource_type: 'DocumentReference'
#                )
#              end



          end

      end  
    end
  end
end
