CC?=clang
CFLAGS?=-Werror -Wall -Wstrict-prototypes -Wundef -Wmissing-declarations \
	-Wmissing-prototypes -std=gnu11 -ggdb3
SRCS=tree.c
TARGET=tree

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm -f $(TARGET)
