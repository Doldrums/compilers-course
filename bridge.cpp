
#include "bridge.h"
#include "types.h"
#include "reader.h"

using namespace std;

C_Token* c_pr_str(Token* elem) {
    if (TokenSymbol* sym = dynamic_cast<TokenSymbol*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_Symbol;
        token->value = sym->name.c_str();
        return token;
    } else if (TokenNumber* num = dynamic_cast<TokenNumber*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_Number;
        token->value = std::to_string(num->value).c_str();
        return token;
    } else if (TokenList* list = dynamic_cast<TokenList*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_List;
        const struct C_Token** tokens = (const struct C_Token**)calloc(list->list.size(), sizeof(struct C_Token*));
        size_t pointer = 0;
        for (Token* elem : list->list) {
            tokens[pointer] = c_pr_str(elem);
            pointer++;
        }
        token->list = tokens;
        token->len = list->list.size();
        return token;
    } else if (TokenString* str = dynamic_cast<TokenString*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_String;
        token->value = str->value.c_str();
        return token;
    } else if (TokenNil* nil = dynamic_cast<TokenNil*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_Nil;
        return token;
    } else if (TokenTrue* t = dynamic_cast<TokenTrue*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_True;
        return token;
    } else if (TokenFalse* f = dynamic_cast<TokenFalse*>(elem)) {
        struct C_Token* token = (struct C_Token*)calloc(1, sizeof(struct C_Token));
        token->type = C_TokenType_False;
        return token;
    } else {
        throw std::runtime_error("unrecognized Token");
    }
}

C_Token* c_read_str(char* chars) {
    string str(chars);

    return c_pr_str(read_str(str));
}
