import 'package:vaden/vaden.dart';

import 'product_dto.dart';
import 'product_repository.dart';

@Api(tag: 'product', description: 'Product Management')
@Controller('/v1/product')
class ProductController {
  final ProductRepository _productRepository;
  ProductController(this._productRepository);

  @ApiOperation(summary: 'List all products')
  @ApiResponse(
    200,
    description: 'List of products',
    content: ApiContent(type: 'application/json', schema: List<Product>),
  )
  @Get('/all')
  Future<List<Product>> getAll() async {
    return await _productRepository.findAll();
  }

  @ApiOperation(summary: 'Get product by ID')
  @ApiResponse(
    200,
    description: 'Product details',
    content: ApiContent(type: 'application/json', schema: Product),
  )
  @ApiResponse(404, description: 'Product not found')
  @Get('/<id>')
  Future<Product> getById(@Param() int id) async {
    return await _productRepository.findById(id);
  }

  @ApiOperation(summary: 'Create a new product')
  @ApiResponse(
    201,
    description: 'Product created successfully',
    content: ApiContent(type: 'application/json', schema: Product),
  )
  @Post('/')
  Future<Product> create(@Body() Product product) async {
    return await _productRepository.create(product);
  }

  @ApiOperation(summary: 'Update an existing product')
  @ApiResponse(
    200,
    description: 'Product updated successfully',
    content: ApiContent(type: 'application/json', schema: Product),
  )
  @ApiResponse(404, description: 'Product not found')
  @Put('/<id>')
  Future<Product> update(@Body() Product product) async {
    await _productRepository.update(product);
    return product;
  }

  @ApiOperation(summary: 'Delete a product')
  @ApiResponse(204, description: 'Product deleted successfully')
  @ApiResponse(404, description: 'Product not found')
  @Delete('/<id>')
  Future<void> delete(@Param() int id) async {
    await _productRepository.delete(id);
  }
}
