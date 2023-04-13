#pragma once

#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))

EXPORT void *init_enviroment();

EXPORT char *parse_line(char *line);

EXPORT char *eval_line(char *line, void *env);
