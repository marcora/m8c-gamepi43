#ifndef RENDER_H_
#define RENDER_H_

#include "command.h"

int initialize_sdl();
void close_renderer();

int process_queues(struct command_queues *queues);
void draw_waveform(struct draw_oscilloscope_waveform_command *command);
void draw_rectangle(struct draw_rectangle_command *command);
int draw_character(struct draw_character_command *command);

void render_screen();
void toggle_fullscreen();

#endif