public with sharing class ExchangeRateService {
//public with sharing class ExchangeRateService implements HttpCalloutMock{
    
    public static final String BASE_RATE ='USD';
    public static final String API_KEY = '0a19c42508c753990a273f64fa3e07cd';

    private List<String> fromCurrencies = new List<String>();
    private Date conversionDate;
    
    public ExchangeRateService(Date conversionDate, List<String> fromCurrencies) {
        this.conversionDate = conversionDate;
        this.fromCurrencies = fromCurrencies;

        if (this.conversionDate == null
                || this.fromCurrencies == null 
                || this.fromCurrencies.isEmpty()) {
            throw new ExchangeRateServiceException ('Missing required arguments');
        }
    }

    public String getFxRates() {
        String conversionDateString; //= String.valueOf(conversionDate);
        String fromCurrenciesString; // = String.join(this.fromCurrencies, ',');

        String endpoint = 'http://data.fixer.io/api/'+
        conversionDateString + '?' +
        'access keys' + API_KEY + '&' +
        'base' + BASE_RATE + '&' +
        'symbols' + fromCurrenciesString;

        HttpRequest req = new HttpRequest();
        req.setTimeout(12000); // optional    
        req.setEndpoint(endpoint); //absolutely mandatory
        req.setMethod ('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);
        Integer statusCode = res.getStatusCode();
        String reponseBody = res.getBody();

        return reponseBody;        
        }

        private class ExchangeRateServiceException extends Exception {}
}