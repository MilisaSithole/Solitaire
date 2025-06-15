public class Card{
    PVector pos;
    float wid, hei;
    String rank, suit;

    public Card(PVector pos, float cardWidth, String rank, String suit){
        this.pos = pos;
        this.wid = cardWidth;
        this.hei = cardWidth / 2.5 * 3.5;
        this.rank = rank;
        this.suit = suit;
    }

    public Card(float x, float y, float cardWidth, String rank, String suit){
        this.pos = new PVector(x, y);
        this.wid = cardWidth;
        this.hei = cardWidth / 2.5 * 3.5;
        this.rank = rank;
        this.suit = suit;
    }

    public void draw(){
        noStroke();
        fill(204);
        rect(pos.x, pos.y, wid, hei, 12);

        textAlign(CENTER, CENTER);
        textSize(24);
        fill(51);
        text(rank + suit, pos.x + wid/2, pos.y + hei/2);
    }
}