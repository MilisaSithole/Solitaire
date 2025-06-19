public class Card{
    PVector pos;
    float wid, hei;
    int rank;
    Suits suit;
    PImage suitImg;

    float fontSize;

    public Card(int rank, Suits suit){
        this.rank = rank;
        this.suit = suit;
        this.wid = width / 7.5 * 0.9;
        this.hei = wid / 2.5 * 3.5;
        this.suitImg = loadImage("Assets/" + suit.getName() + ".png");
        this.fontSize = wid * 0.3;
    }

    public void draw(){
        noStroke();
        fill(250);
        rectMode(CENTER);
        rect(pos.x, pos.y, wid, hei, 12);

        drawRankAndSuit();
    }

    public void draw(float x, float y){
        pos = new PVector(x, y);
        draw();
    }

    public boolean isClicked(float x, float y) {
        return x > pos.x - wid/2 && x < pos.x + wid/2 &&
               y > pos.y - hei/2 && y < pos.y + hei/2;
    }

    public float getWidth() {
        return wid;
    }

    public float getHeight() {
        return hei;
    }

    public void setPosition(PVector pos) {
        this.pos = pos;
    }

    private void drawRankAndSuit() {
        color colour = suit == Suits.HEARTS || suit == Suits.DIAMONDS ? color(250, 50, 100) : color(51);

        textAlign(CENTER, CENTER);
        imageMode(CENTER);
        textSize(fontSize);
        suitImg.resize((int)fontSize, 0);

        float rankTextWidth = textWidth(getRankSymbol(rank));
        float totalWidth = rankTextWidth + suitImg.width;
        
        fill(colour);
        text(getRankSymbol(rank), pos.x + rankTextWidth/2 - totalWidth/2, pos.y);
        tint(colour);
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

    @Override
    public String toString() {
        return getRankSymbol(rank) + " of " + suit.getName() + "s";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Card)) return false;
        Card other = (Card) obj;
        return rank == other.rank && suit == other.suit;
    }
}