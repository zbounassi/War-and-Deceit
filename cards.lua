-- Holds all of the card ranks 
Ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"}

-- Holds all of the card suits
Suits = {"Hearts", "Diamonds", "Spades", "Clubs"}

-- Holds the information of a single card
Card = {
    rank = "",
    suit = "",
    cardImg = ""
}

Card.__index = Card

-- Constructor definition that will grant the information and image linking to a card
function Card:new(rank, suit)
    local imagePath = "assets/cards/" .. rank .. "_of_" .. suit .. ".png"
    local card = {
        rank = rank, 
        suit = suit,
        -- image = love.graphics.newImage(imagePath)
    }
    setmetatable(card, Card)
    return card
end

function Card:printCard()
    print(self.rank .. " of " .. self.suit)
end

-- Deck declaration (maybe need more in here)
Deck = {
    length = 0,
    crtCard = 0,
    cards = {}
}

Deck.__index = Deck

-- Constructor definition to make a Deck
function Deck:new()
    local newDeck = {
        length = 0,
        crtCard = 0,
        cards = {}
    }
    self.cards[0] = {"placeHolder"}
    setmetatable(newDeck, Deck)
    return newDeck
end

-- Function to make a deck with all cards (not currently working)
function Deck:makeDeck()
    local deckCt = 1
    for i,v in ipairs(Ranks) do 
        for l, p in ipairs(Suits) do
            local card = Card:new(Ranks[i], Suits[l])
            self.cards[deckCt] = card
            deckCt = deckCt + 1
        end
        self.length = deckCt - 1
        self.crtCard = 1
    end
    return self
end

-- Function to print all cards in the deck
function Deck:printDeck()
    for i,v in ipairs(self.cards) do
        self.cards[i]:printCard()
    end    
end


-- Function to shuffle the order of cards in a deck
function Deck:shuffleDeck()
    math.randomseed()
    local holderDeck = Deck:new()
    local cards = 52
    local rand = 0
    local i = 1

    while(cards > 0) do
        rand = math.random(cards)
        holderDeck.cards[i] = self.cards[rand]
        while(rand <= cards) do
            self.cards[rand] = self.cards[rand + 1]
            rand = rand + 1
        end
        i = i + 1
        cards = cards - 1
    end
    
    return holderDeck
end

-- Function to split a deck of cards into two halves
function Deck:splitDeck()
    local half1 = Deck:new()
    local half2 = Deck:new()
    local ctOne = 1 
    local ctTwo = 1
    
    for i,v in ipairs(self.cards) do
        if(i % 2 == 0) then
            half2.cards[ctTwo] = self.cards[i]
            ctTwo = ctTwo + 1
        else
            half1.cards[ctOne] = self.cards[i]
            ctOne = ctOne + 1
        end
    end

    return half1, half2
end

-- Creates a Deck named testDeck
local testDeck = Deck:new()

-- local testCard = Card:new("Ace", "Diamonds")

-- testCard:printCard() 

testDeck:makeDeck()

--[[

The split function is working as intended

local split1 = Deck:new()
local split2 = Deck:new()

split1, split2 = testDeck:splitDeck()

split1:printDeck()

print("\n this is the point between 1 and 2 \n ")

split2:printDeck()
]]--

print("\nTesting the shuffle deck function\n")

local shuff, testDeck = testDeck:shuffleDeck()
shuff:printDeck()
