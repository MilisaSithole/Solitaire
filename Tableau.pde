public class Tableau extends CardHolder {
    float hiddenHeight = cardHeight * 0.1;
    float hiddenFontSize = hiddenHeight * 0.8;

    public Tableau(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        int numHiddenCards = cards.size() - 1;
        drawHidden(numHiddenCards);

        float offset = numHiddenCards < 1 ? 0 : hiddenHeight * (numHiddenCards + 1);
        cards.get(cards.size()-1).draw(pos.x, pos.y + offset);
    }

    private void drawHidden(int numHiddenCards) {
        if (numHiddenCards < 1) return;

        fill(250, 50, 100);
        rectMode(CENTER);
        rect(pos.x, 
            pos.y - cardHeight/2 + hiddenHeight*numHiddenCards/2, 
            cardWidth, 
            hiddenHeight*numHiddenCards, 
            12);

        textAlign(CENTER, CENTER);
        textSize(hiddenFontSize);
        fill(51);
        text(numHiddenCards, pos.x, pos.y - cardHeight/2 + hiddenHeight*numHiddenCards/2);
    }
}