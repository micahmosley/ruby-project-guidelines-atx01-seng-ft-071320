class ImportToDatabase 
    url='https://opentdb.com/api.php?amount=50&category=9&type=boolean'
    uri=URI.parse(url)
    response = Net::HTTP.get_response(uri)
    fact_hash=JSON.parse(response.body)
    fact_hash['results'].each do |fact| 
        Fact.create(fact: fact["question"], true_or_false: fact["correct_answer"])
    end 

    #Fix formatting of our questions.
    #Replaces '&quot;' with " " and replaces '&#039;' with an '
    Fact.all.each do |fact|
        i=fact.fact.sub! '&quot;', "'" 
        j=fact.fact.sub! '&#039;', "'" 
        if i && j==nil
            while i do
                i=fact.fact.sub! '&quot;', "'" 
            end 
        elsif j && i==nil
            while j do 
                j=fact.fact.sub! '&#039;', "'" 
            end 
        elsif i && j 
            while i||j do 
                i=fact.fact.sub! '&quot;', "'" 
                j=fact.fact.sub! '&#039;', "'" 
            end 
        end 

    end

end 