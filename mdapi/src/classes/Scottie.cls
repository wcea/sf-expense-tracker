public with sharing class Scottie extends Dog{
    
    public String character;

     public Scottie() {
        super();
    }

    public Scottie(String name){
        super('Scottie', name);
        this.character = 'stubborn';
    }

    public override void play(){
        System.debug('Scottie karate play');
    }

    public override void walk(){
        System.debug('Scottie trot walk');
    }

    public override void pee(){
        System.debug('Scottie pee');
    }

    public override void come(){
        System.debug('Scottie [dont] come');
    }

    public void snort(){
        System.debug('Scottie snort');
    }

    public void createMyDog() {
        Scottie katana = new Scottie('Katana');
    }
}
