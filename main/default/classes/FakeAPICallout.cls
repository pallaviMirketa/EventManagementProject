public class FakeAPICallout{
    public static HttpResponse createRecord() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://fakestoreapi.com/products');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            String response = res.getBody();
            
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response);

            //Lists to Insert Products 
         List<Product2> proList = new List<Product2>();
            List<PricebookEntry> entryList = new List<PricebookEntry>();
             List<PricebookEntry> entryList2 = new List<PricebookEntry>();
             id standardPriceBookId;

   // Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];

            Pricebook2 pb = new Pricebook2(
            Name = 'pallavi-pricebook',
            Description = 'Pricebook(Custom)', 
            IsActive = true);
            insert pb;

            if(test.isRunningTest()){

                standardPriceBookId=test.getStandardPricebookId();
              }else{
                
                Pricebook2 standardPriceBook= [select id from Pricebook2 where IsStandard=true];
                
            standardPriceBookId=standardPriceBook.id;
                
            }

         //   Pricebook2 standardPB = [select id from Pricebook2 where isStandard = true];
            //ID to store the data

            for (Object product : results) {
                Map<String, Object> productMap = (Map<String, Object>) product;
                
               //taking data from json without curly braces
                String title = (String) JSON.serialize(productMap.get('title'));
                title = title.substring(1, title.length() - 1);
                
                String descript = (String) JSON.serialize(productMap.get('description'));
                descript = descript.substring(1, descript.length() - 1);


                Product2 pro = new Product2(
                    ProductCode = (String) JSON.serialize(productMap.get('id')),
                    Name = title,
                    Description = descript
                );

                proList.add(pro);
            }

            insert proList;

            for (integer i = 0; i <results.size(); i++) {
                Object product = results.get(i);
                Id productId = proList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;

                Decimal priceDecimal = (Decimal)productMap.get('price');

                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = standardPriceBookId,
                    Product2Id = productId,
                    UnitPrice = priceDecimal,
                    IsActive = true
                );

                entryList.add(entry);
            }
            
   insert entryList;

            
          for (integer i = 0; i <results.size(); i++) {
                Object product = results.get(i);
                Id productId = proList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;

                Decimal priceDecimal = (Decimal)productMap.get('price');
                
                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = pb.Id,
                    Product2Id = productId,
                    UnitPrice = priceDecimal,
                    IsActive = true
                );

                entryList2.add(entry);
            }
            
            insert entryList2;
            
        }
        return res;

    }
}