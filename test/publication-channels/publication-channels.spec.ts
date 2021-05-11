const supertest = require( 'supertest' );


describe( 'Publication Channels', () => {
	describe( 'GET /publication-channels', () => {

		it( 'returns status 200', async () => {
			await supertest( 'http://localhost' )
				.get( '/publication-channels' )
				.expect( 200 );
		} );

		it( 'returns a body that contains a "data" array', async (  ) => {
			await supertest( 'http://localhost' )
				.get( '/publication-channels' )
				.expect( ( res ) => {
					return Array.isArray(res.body.data);
				} )
		} );


	} );
} );



