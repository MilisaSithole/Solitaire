public class Card{
    PVector pos;
    float wid, hei;
    int rank;
    Suits suit;
    PImage suitImg;

    float fontSize = 24;

    public Card(PVector pos, int rank, Suits suit){
        this.pos = pos;
        this.wid = width / 7 * 0.9;
        this.hei = wid / 2.5 * 3.5;
        this.rank = rank;
        this.suit = suit;
        this.suitImg = loadImage("Assets/" + suit.getName() + ".png");
    }

    public Card(float x, float y, int rank, Suits suit){
        this(new PVector(x, y), rank, suit);
    }

    public void draw(){
        noStroke();
        fill(204);
        rectMode(CENTER);
        rect(pos.x, pos.y, wid, hei, 12);

        drawRankAndSuit();
    }

    private void drawRankAndSuit() {
        textAlign(CENTER, CENTER);
        imageMode(CENTER);
        textSize(fontSize);
        suitImg.resize((int)fontSize, 0);

        float rankTextWidth = textWidth(getRankSymbol(rank));
        float totalWidth = rankTextWidth + suitImg.width;
        
        fill(51);
        text(getRankSymbol(rank), pos.x + rankTextWidth/2 - totalWidth/2, pos.y);
        tint(color(51));
        image(suitImg, pos.x + totalWidth/2 - suitImg.width/2, pos.y);
        noTint();
    }

    private String getRankSymbol(int rank) {
        switch (rank) {
            case 1: return "A";
            case 11: return "J";
            case 12: return "Q";
            case 13: return "K";
            default: return String.valueOf(rank);
        }
    }
}