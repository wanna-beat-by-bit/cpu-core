.PHONY: dev-build dev subdir_src test_all test_alu context

dev-build:
	docker compose build veridev

dev:
	docker compose up veridev

test_all:
	$(MAKE) -C src test_all

test_alu: test_alu
	$(MAKE) -C src test_alu

context:
	$(MAKE) -C src context

clean:
	$(MAKE) -C src clean