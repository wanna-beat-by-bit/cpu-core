.PHONY: dev-build dev 

dev-build:
	docker compose build veridev

dev:
	docker compose up veridev

# delegation
.PHONY: test_all test_alu context context_alu clean

test_all test_alu context context_alu clean:
	$(MAKE) -C src $@