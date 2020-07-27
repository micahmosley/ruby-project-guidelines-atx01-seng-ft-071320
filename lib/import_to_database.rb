class ImportToDatabase 
    url='https://opentdb.com/api.php?amount=50&category=9&type=boolean'
    uri=URI.parse(url)
    response = Net::HTTP.get_response(uri)
    fact_hash=JSON.parse(response.body)
    fact_hash['results'].each do |fact| 
        Fact.create(text: fact["question"], true_or_false: fact["correct_answer"])
    end 
end 