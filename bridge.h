#include <memory>

#pragma once

enum C_TokenType {
    C_TokenType_List,
    C_TokenType_Symbol,
    C_TokenType_String,
    C_TokenType_Number,
    C_TokenType_True,
    C_TokenType_False,
    C_TokenType_Nil
};

struct C_Token {
    C_TokenType type;
    const char* value;
    const C_Token** list;
    size_t len;
};

C_Token* c_read_str(char* string);