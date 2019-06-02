public virtual with sharing class Dog {

    protected String breed;
    protected String name;
    protected String age;
    protected String gender;
    protected String weight;
    protected List<Dog> friends;
    private String butt;

    public Dog() {
        
    }

    public Dog(String breed, String name) {
        this.breed = breed;
        this.name = name;
    }

    public virtual void sit(){
        System.debug('Sit');
    }

    public virtual void play(){
        System.debug('Play');
    }

    public virtual void walk(){
        System.debug('Walk');
    }

    public virtual void come(){
        System.debug('Come');
    }

    public void sniff(String target){
        System.debug('Sniff ' + target);
    }

    public virtual void pee(){
        System.debug('Pee');
    }

    public virtual void poop(){
        System.debug('Poop');
    }
    
    public static void sniffButts(Dog dog1, Dog dog2){
        dog1.sniff(dog2.butt);
        dog2.sniff(dog1.butt);
    }

    public virtual void getButt(){
        System.debug(this.name + ' butt');
    }

    public static Map<Id, List<Trail__c>> getTrailLocation(){
        List<TrailLocation__c> locations = [
            SELECT
                ID,
                NAME,
                (SELECT ID, NAME FROM TRAILS__R)
            FROM TrailLocation__c
        ];
        Map<ID, List<Trail__c>> trailsByLocation = new Map<ID, List<Trail__c>>();
        for (TrailLocation__c location : locations){
            trailsByLocation.put(location.Id, location.Trails__r);
        }
        return trailsByLocation;
    }
}
