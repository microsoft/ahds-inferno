require_relative 'hls_patient_name_search_test'

module USCoreTestKit
    module USCoreV400
        module HLSBasicTestKit
            class HLSBasicTestGroup < Inferno::TestGroup
                title 'MSUS HLS Basic Tests'
                description 'Practice writing Inferno tests to validate behavior'
                id :hls_basic_tests

                # All FHIR requests in this suite will use this FHIR client (pulls from global url / creds)
                fhir_client do
                    url :url
                    oauth_credentials :smart_credentials
                end
                
                test from: :hls_patient_name_validate_test
                test from: :hls_patient_name_search_test

                test do
                    title 'Sample test of boolean logic'
                    input :should_pass,
                        title: 'true if the test should pass, false if it should fail'

                    run do
                        # Couldn't get outputs working
                        #output value1: should_pass
                        #output dar_extension_found: 'true'

                        assert pass==true
                        puts "Log: User passed in '#{should_pass}' which will result in #{(pass ? 'success' : 'failure')}"   

                        # Assert must happen after outputs - execution stops immediately
                        pass = ((should_pass.downcase)=='true')
                    end
                end
            end
        end    
    end
end
